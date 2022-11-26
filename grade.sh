#Grading script inspired by groupmate work in Lab!
CPATH=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"

rm -rf student-submission
git clone $1 student-submission

cp TestListExamples.java student-submission
cp -r lib student-submission
cd student-submission

#Check for file existance/correct name
if [ -e ListExamples.java ]

then
    echo "Found submission"
else
    echo "Submission not found. make sure file name matches ListExample.java!"
    exit 1
fi

#Compile
pwd
javac -cp CPATH *.java 2> err.txt

#Check for compile error
if [ $? -eq 1 ]
then
    echo "Compile error!!!"
    cat err.txt
    exit 1
fi

#Run tests
java -cp CPATH
org.junit.runner.JUnitCore TestListExamples 2> err.txt > out.txt

echo "Tests running"

#Tally score
FAILS=$(head -n 2 out.txt | tail -n 1 | grep -o "E" | wc -1)
TESTS=$(head -n 2 out.txt | tail -n 1 | grep -o "\." | wc -1)

echo "$(($TESTS - $FAILS))" tests passed out of $TESTS

exit