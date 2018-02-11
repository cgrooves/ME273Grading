# ME273Grading
FOR BYU ME 273 TA/Professor USE ONLY

Files necessary to run autograder routine for ME 273 labs.

External files necessary to run (place in directory with gradeLab.m and Core)
1. roster.csv - Roster file with columns as follows:
  Last name, first name, Net ID, email, BYU ID, Last 4, Last 4, Course Homework ID, Section number
  The two last 4 columns are redundant, and the course homework ID is not used in the autograder routine.
2. labresponses.csv - TAB-SEPARATED download of the online google forms responses (yes, it is Tab-Separated, but named .csv - MATLAB doesn't know how to read a .tsv filetype, so you have to rename it to be .csv)
  Critical Columns: Timestamp, Last 4 of ID, Self-Evaluation, Self-Evaluation score, Self-evaluation feedback, Peer Observation Score, Peer Observation Feedback
  Other columns are not used.
3. grader functions - these are MATLAB functions that will grade each part of the lab. The function template is given in the Core directory.
4. File response folders - each of these folders should have the assignment description ('Animation', 'SixDerivs') in their name, and contain all of the student submissions from the Google Forms.

To create an autograder for a lab, write functions for each of the lab parts. Then, go into 'gradeLab.m' and change the Lab and Assignment objects listed at the %% CREATE LAB -------- heading. Be sure to add in the grading functions to the graderFunctions map, and change the lab due date.

Resubmission (untested):

Change the resubmission flag to 1 to run the grader in resubmission mode. This will extend the due date out by 1 week, and only look at file submissions between the original due date and this extended due date. It will also dock 20% off of each assignment that is re-graded during this portion for the student, and add explanatory feedback.
