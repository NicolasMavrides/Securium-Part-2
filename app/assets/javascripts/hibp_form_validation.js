/* Javascript code for client-side validation of the email form for
   HaveIBeenPwned (HIBP) service
*/

const form = document.getElementById("email_form")
const email = document.getElementById('search_email')
const errElement = document.getElementById('error')

function ValidateEmail(inputText) {
  var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
  if(inputText.value.match(mailformat)) {
    document.form.email.focus();
    return true;
  } else {
    document.form.email.focus();
    return false;
  }
}
