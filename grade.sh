# Create your grading script here

# set -e

rm -rf student-submission &>/dev/null
git clone $1 student-submission &>/dev/null
cp TestListExamples.java student-submission/ &>/dev/null
cp -r lib student-submission/ &>/dev/null
if [ ! -e student-submission/ListExamples.java ] 
    then 
        echo "Student submission does not contain proper files" 
        exit 1
fi

pushd student-submission &>/dev/null

javac -cp .:lib/hamcrest-core-1.3.jar:lib/Junit-4.13.2.jar *.java 2> /dev/null
if [ ! $? -eq 0 ]
    then   
        echo "Compiler error"
        exit 1
fi
java -cp .:lib/hamcrest-core-1.3.jar:lib/Junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > TestResults.txt

if grep "OK" TestResults.txt &>/dev/null
    then
        echo "All Tests Passed"
fi
if grep "FAILURES" TestResults.txt &>/dev/null
    then
        echo "Failed"
fi

popd &>/dev/null