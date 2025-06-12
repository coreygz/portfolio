import datetime
import json
import os
import re
from tool.Twitter import Tweet  # Keeping original structure

# Helper functions for feature extraction
def is_retweet(tweet):
    return 1 if "retweeted_status" in tweet else 0

def count_media(tweet):
    return len(tweet.get("entities", {}).get("media", [])) if "entities" in tweet else 0

def encode_source(source):
    if "iPhone" in source:
        return 1
    elif "Android" in source:
        return 2
    elif "Web" in source:
        return 3
    else:
        return 0  # Other sources

def get_username_length(user):
    return len(user.screen_name) if hasattr(user, "screen_name") else 0  
def has_mentions(tweet):
    return 1 if len(tweet.get("entities", {}).get("user_mentions", [])) > 0 else 0

def count_words(text):
    return len(text.split())

def count_punctuation(text):
    return sum(1 for char in text if char in ".,!?;:")  # Counts common punctuation marks

def get_weekday(created_at):
    if not created_at:
        return -1  # Handle missing dates
    try:
        dt = datetime.datetime.strptime(created_at, "%a %b %d %H:%M:%S +0000 %Y")
        return dt.weekday()
    except ValueError:
        return -1  # If parsing fails, return -1

# Processing tweets
start_date = "20201117"
end_date = "20210521"
start_date_datetime = datetime.datetime.strptime(start_date, "%Y%m%d")
end_date_datetime = datetime.datetime.strptime(end_date, "%Y%m%d")
proc_date = start_date_datetime
duration = 300  # Number of days to process

data_check_list = os.listdir("Data/")
data_check_dic = {i: 1 for i in data_check_list}

for _ in range(duration):
    proc_date_str = proc_date.strftime("%Y-%m-%d")

    input_data_folder_path = "Data/" + proc_date_str + "/"
    output_data_folder_path = "Tmp/" + proc_date_str + "/"

    if proc_date_str not in data_check_dic.keys():
        proc_date = proc_date + datetime.timedelta(days=1)
        if proc_date == end_date_datetime:
            break
        continue

    if not os.path.exists(output_data_folder_path):
        os.makedirs(output_data_folder_path)

    output_data_file = output_data_folder_path + "tweet_feature"
    with open(output_data_file, "w", encoding="utf-8") as file_out:

        for filename in os.listdir(input_data_folder_path):
            input_data_path = input_data_folder_path + filename

            with open(input_data_path, "r", encoding="utf-8", errors="ignore") as file_in:
                for line in file_in:
                    try:
                        tweet = json.loads(line)
                        tweet_obj = Tweet(tweet)
                    except:
                        print("Error processing tweet:", line)
                        continue

                    if not tweet_obj.is_en():
                        continue

                    # Extract tweet and user info
                    tweet_id = tweet_obj.get_id()
                    user_id = tweet_obj.user.id_str

                    # Extract new features
                    word_cnt = count_words(tweet_obj.text)  
                    rt_status = is_retweet(tweet)
                    med_cnt = count_media(tweet)
                    src_type = encode_source(tweet.get("source", ""))
                    usr_len = get_username_length(tweet_obj.user)  
                    has_ment = has_mentions(tweet)
                    punc_cnt = count_punctuation(tweet_obj.text)  
                    day = get_weekday(tweet.get("created_at", ""))  

                    # Write features to file
                    file_out.write(f"{tweet_id}\t{user_id}\t{word_cnt}\t{rt_status}\t{med_cnt}\t{src_type}\t{usr_len}\t{has_ment}\t{punc_cnt}\t{day}\n")
                    file_out.flush()

    proc_date = proc_date + datetime.timedelta(days=1)
    if proc_date == end_date_datetime:
        break
