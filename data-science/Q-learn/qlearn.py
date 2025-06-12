import random

# board
board_size = 4
actions = ['up','right','down','left']

# parameters
gamma = 0.1  # discount
alpha = 0.3  # learning rate
epsilon = 0.5  # E-greedy

# Rewards
liv_r =-0.1
goal_r = 100
forbid_r =-100

# initialize q-table
q_table = []
for state in range(board_size**2):
    state_q_values = []
    for action in actions:
        state_q_values.append(0)
    q_table.append(state_q_values)


def state_to_position(state):
    # change state index to row and col
    row = 3 - (state -1)//board_size
    col = (state-1)%board_size
    return row, col


# choose using e-greedy policy
def choose_action(state, q_values, epsilon):
    state_index = state -1
    if random.uniform(0,1) < epsilon:
        # Explore:choose random action
        return random.choice(actions)
    else:
        #  Exploit: choose action with max qvalue
        max_q = max(q_values[state_index])  # find max qvalue for the state

        best_actions = []
        for i in range(len(q_values[state_index])):
            if q_values[state_index][i] ==max_q:
                best_actions.append(i)

        for action in [0, 1, 2, 3]:
            if action in best_actions:
                return actions[action]


# update Q-value
def update_q_value(state, action, reward, nxt):
    global q_table

    state_index = state - 1
    nxt_index = nxt - 1

    action_index = actions.index(action)
    current_q = q_table[state_index][action_index]

    # find max Q-value for the next
    bestnxtact_value = max(q_table[nxt_index])

    # formula
    new_q_value = (1 -alpha)*current_q +alpha*(reward +gamma*bestnxtact_value)

    q_table[state_index][action_index] = new_q_value



def act(state, action, goals, forbid, wall):

    if action == 'up':
        if state +4 > 16:
            return state, liv_r, False
        nxt = state + 4
    elif action == 'down':
        if state - 4 < 1:
            return state, liv_r, False
        nxt = state - 4
    elif action == 'left':
        if state %4 ==1:
            return state, liv_r, False
        nxt = state - 1
    elif action == 'right':
        if state % 4 == 0:
            return state, liv_r, False
        nxt = state + 1

    # wall check
    if nxt == wall:
        return state, liv_r, False

    # forbid square
    if nxt == forbid:
        return nxt, forbid_r, True

    #  goal
    if nxt in goals:
        return nxt, goal_r, True

    return nxt, liv_r, False


# run q-learning
def q_learn(start, goals, forbid, wall, max_iterations=100000):
    iteration = 0

    while iteration <max_iterations:
        current_state = start
        is_done = False

        while is_done == False:
            #  Choose action based on the egreedy
            action = choose_action(current_state, q_table, epsilon)

            nxt, reward, is_done = act(current_state, action, goals, forbid, wall)
            # Update q-value for current
            update_q_value(current_state, action, reward, nxt)

            # move to next
            current_state = nxt

        iteration += 1


#round to 2 sig figures
def roundtwosig(value, sig=2):
    if value == 0:
        return 0
    else:
        return round(value, sig - int(len(str(int(abs(value))))))

# Optimal policy
def opt_policy(goals, forbid, wall):
    for state in range(1, board_size ** 2 + 1):
        if state == wall:
            print(str(state) +" "+"wall-square")
        elif state == forbid:
            print(str(state) +" "+"forbid")
        elif state in goals:
            print(str(state) + " "+"goal")
        else:
            #  get q-values for current state
            q_values = q_table[state -1]

            # find max Q-value
            max_q = max([roundtwosig(q) for q in q_values])

            #  order: up, right, down, left
            if roundtwosig(q_values[0]) == max_q:
                best_action = 'up'
            elif roundtwosig(q_values[1]) == max_q:
                best_action = 'right'
            elif roundtwosig(q_values[2]) == max_q:
                best_action = 'down'
            elif roundtwosig(q_values[3]) == max_q:
                best_action = 'left'

            # Print  best action
            print(str(state)+ " "+best_action)


# print q value
def printqv(state):
    q_values = q_table[state - 1]
    for i in range(4):
        q_value = q_values[i]
        if q_value == 0:  
            print(actions[i] + " " + "0.0")
        else:
            print(actions[i] + " " + str(round(q_value, 2)))



# handle input
def handle_input():
    input_line = input("Enter:   ").strip()
    parts = input_line.split()

    # get variables
    goal1 = int(parts[0])
    goal2 = int(parts[1])
    forbid = int(parts[2])
    wall = int(parts[3])
    mode = parts[4]

    goals = [goal1, goal2]

    if mode == 'p':
        # find the policy
        q_learn(1, goals, forbid, wall)
        opt_policy(goals, forbid, wall)
    elif mode == 'q':
        state = int(parts[5])  # Get state
        q_learn(1, goals, forbid, wall)
        printqv(state)


handle_input()