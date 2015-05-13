function loadSignIn() {
    $('#forFade').fadeOut("slow", function(){
        $('#fade1').replaceWith("<div style='font-size: 18px' id = 'fade1'>Please input a username and </div>");
        $('#fade2').replaceWith("<div style='font-size: 18px' id = 'fade2'>password to Sign In!</div>");
        $('#fade3').replaceWith("<form method='post' action='/user/signIn'> <label for = 'username'>Username: </label> <input type = 'text' name = 'username' class = 'SignUpInput'><br> <label for = 'password'>Password:</label> <input type = 'password' name='password' class = 'SignUpInput'><br> <input type='submit' value = 'Sign In' class='btn btn-info' style = 'margin: 5px'> </form>");
        $('#fade4').replaceWith("<a style = 'font-size: 15px' href='/'>Not a User, Sign in Here</a>");
        $('#forFade').fadeIn("slow");
    });
}

function create() {
    $(".createNewThread").animate({ "height": "250px", "width": "550px"}, "slow" );
    $(".createNewThread").append("<form method = 'post' action = '/thread/create' style = 'font-size: 20px' class = 'form-horizontal'>  <div class='form-group' style = 'margin: 7px'>  <label for = 'name'>Name: </label>  <input class='form-control' type = 'text' name = 'name' placeholder='Ex: iPhoto Help' style = 'width: 300px'>  </div>  <div class='form-group' style = 'margin: 7px'>  <label for = 'des'>Description: </label>  <input class='form-control' type = 'text' name = 'des' style = 'width: 500px' placeholder = 'Please provide a short description for your thread.'> </div>  <input type='submit' value='Create Thread!' class = 'btn btn-primary'>  </form>")
    $('html, body').animate({scrollTop:$(document).height()}, 'slow');

}

function create2() {
    $(".createNewPost").animate({ "height": "250px", "width": "100%", "text-align": "left"}, "slow" );
    form = $(".formTemplate").clone()
    form.removeClass( "formTemplate" ).addClass( "formShowTemplate" );
    $(".createNewPost").append(form)
}

function checkSignUp(user, pass, conPass) {
    var $errorMessage;


    if (pass !== conPass) {
        if (user === "" || pass === "" || conPass === "") {
            $errorMessage = "Please make sure your passwords match and you have filled all fields out"
        }
    }

    return($errorMessage)

}

$( ".already" ).one("click", loadSignIn)
$(".createNewThread").one("click", create)
$(".createNewPost").one("click", create2)

$('.signUpSubmit').click(function() {
    var username = $('#signUpInput1').val();
    var password = $('#signUpInput2').val();
    var conPassword = $('#signUpInput3').val();
    $('.error').html(checkSignUp(username, password, conPassword));
});