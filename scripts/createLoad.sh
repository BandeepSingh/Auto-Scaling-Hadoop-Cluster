#!/bin/bash
# My first script

echo "Creating Load!"
#input-001.txt
yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait1=$!
yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait2=$!
yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait3=$!
yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait4=$!
yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait5=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait6=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait7=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait8=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait9=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait10=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait11=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait12=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait13=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait14=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait15=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait16=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait17=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait18=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait19=$!
#yarn jar euler.jar EulerEstimator /test/eulerInputs/input-010.txt & wait20=$!

wait $wait1
wait $wait2
wait $wait3
wait $wait4
wait $wait5
#wait $wait6
#wait $wait7
#wait $wait8
#wait $wait9
#wait $wait10
#wait $wait11
#wait $wait12
#wait $wait13
#wait $wait14
#wait $wait15
#wait $wait16
#wait $wait17
#wait $wait18
#wait $wait19
#wait $wait20
