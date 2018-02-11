// ----------------------------------------------------------------------------------
// Purpose: Assist with automatic feedback to students about their lab scores and any
// MATLAB stack trace associated with their submission.
// ----------------------------------------------------------------------------------

function gradingFeedback() {
  
  // setup spreadsheet
  var spreadSheet = SpreadsheetApp.getActiveSheet();
  var dataRange = spreadSheet.getDataRange();
  
  // get data
  var data = dataRange.getValues();
  
  
  // For each student
  for (var i = 1; i < data.length; i++)
  {
    var row = data[i];
    var lastName = row[0];
    var firstName = row[1];
    var BYUID = row[2];
    var last4 = row[3];
    var email = row[4];
    var labName = row[5];
    var labScore = Math.round(row[6]*100);
    var selfEvalScore = Math.round(row[7]*100);
    var selfEvalFeedback = row[8];
    var peerObsScore = Math.round(row[9]*100);
    var peerObsFeedback = row[10];
    
    // get info for each assignment
    var assignmentBreakdown = '';
    
    for (var j = 11; j < row.length; j+=9)
    {
      var assignmentName = row[j];
      var assignmentScore = Math.round(row[j+1]*100);
      var assignmentFeedback = row[j+2];
      var codeScore = Math.round(row[j+3]*100);
      var codeFeedback = row[j+4];
      var headerScore = Math.round(row[j+5]*100);
      var headerFeedback = row[j+6];
      var commentScore = Math.round(row[j+7]*100);
      var commentFeedback = row[j+8];
      
      if (assignmentFeedback == 'This assignment was submitted on time') {
        assignmentFeedback = 'none';
      }
      
      // formulate feedback string
      var line1 = assignmentName + ' Assignment ---------------------------------\n';
      var line2 = 'Total Score:\t' + assignmentScore + ' % \n';
      var line3 = 'General Feedback:\t' + assignmentFeedback + '\n';
      var line4 = 'Code Score:\t' + codeScore + ' % \n';
      var line5 = 'Code Feedback:\t' + codeFeedback + '\n';
      var line6 = 'Header Score:\t' + headerScore + ' % \n';
      var line7 = 'Header Feedback:\t' + headerFeedback + '\n';
      var line8 = 'Comment Score:\t' + commentScore + ' % \n';
      var line9 = 'Comment Feedback:\t' + commentFeedback + '\n';
      var line10 = '---------------------------------------------------------------\n\n';
      
      assignmentBreakdown += line1 + line2 + line3 + line4 + line5 + line6 + line7 + line8 + line9 + line10;
    }
    
    // hook together text
    var opener = firstName + ' ' + lastName + ':\n\n';
    var intro = 'The following feedback was automatically generated from your recent ' + labName + ' submission. \n\n';
    
    var line1 = '///////////////////*** ' + labName + ' ***//////////////////\n\n';
    var line2 = 'Lab Score:\t' + labScore + ' % \n';
    var line3 = 'Self Evaluation Score:\t' + selfEvalScore + ' % \n';
    var line4 = 'Self Evaluation Feedback:\t' + selfEvalFeedback + '\n';
    var line5 = 'Peer Observation Score:\t' + peerObsScore + ' % \n';
    var line6 = 'Peer Observation Feedback:\t' + peerObsFeedback + '\n\n';
    var line7 = '**************Assignment Breakdown*****************\n';
    var line8 = assignmentBreakdown;
    
    var ending = '**If you have any questions on your grade, please contact one of the TA\'s during office hours.';    
    
    var text = opener + intro + line1 + line2 + line3 + line4 + line5 + line6 + line7 + line8 + ending;
    var subject = labName + ' grading';
    
    // send email
    MailApp.sendEmail(email,subject, text);
  }
  
}


