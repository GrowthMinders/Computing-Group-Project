 function validate(){
   
   const simple = /[a-z]+/;
   const capital = /[A-Z]+/;
   const digit = /[0-9]+/;
   const special = /[~`!@#$%^&*()_+={}:;'"<>,.?]+/;
   const size = /^[a-zA-Z0-9~`!@#$%^&*()_+={}:;'"<>,.?]{8,24}$/;


    var container = document.getElementById("errdisplay");
    if(document.getElementById("pass").value.length === 0) {
       container.removeAttribute("hidden");
       container.innerText  = '* Please enter a password';
       container.style.color = "red";
       container.style.fontSize = "18px";
       container.style.fontWeight = "bold";

    }else if(document.getElementById("cpass").value.length === 0){
       container.removeAttribute("hidden");
       container.innerText  = '* Confirm the password';
       container.style.color = "red";
       container.style.fontSize = "18px";
       container.style.fontWeight = "bold";

    }else if(document.getElementById("pass").value != document.getElementById("cpass").value){
       container.removeAttribute("hidden");
       container.innerText  = '* Passwords do not match';
       container.style.color = "red";
       container.style.fontSize = "18px";
       container.style.fontWeight = "bold";

    }else if(!simple.test(document.getElementById("pass").value)){
      container.removeAttribute("hidden");
      container.innerText  = '* Password should at least contain a single simple letter';
      container.style.color = "red";
      container.style.fontSize = "18px";
      container.style.fontWeight = "bold";
    
    }else if(!capital.test(document.getElementById("pass").value)){
      container.removeAttribute("hidden");
      container.innerText  = '* Password should at least contain a capital simple letter';
      container.style.color = "red";
      container.style.fontSize = "18px";
      container.style.fontWeight = "bold";
   
    }else if(!digit.test(document.getElementById("pass").value)){
      container.removeAttribute("hidden");
      container.innerText  = '* Password should at least contain a digit';
      container.style.color = "red";
      container.style.fontSize = "18px";
      container.style.fontWeight = "bold";

    }else if(!special.test(document.getElementById("pass").value)){
      container.removeAttribute("hidden");
      container.innerText  = '* Password should at least contain a special character';
      container.style.color = "red";
      container.style.fontSize = "18px";
      container.style.fontWeight = "bold";

    }else if(!size.test(document.getElementById("pass").value)){
      container.removeAttribute("hidden");
      container.innerText  = '* Password length(8-24)';
      container.style.color = "red";
      container.style.fontSize = "18px";
      container.style.fontWeight = "bold";

    }else{
       document.forms["reset"].submit();
    }   
 } 
