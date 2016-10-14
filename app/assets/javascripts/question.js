function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before(content.replace(regexp, new_id));
}
function remove_fields(link) {
  $(link).prev('input[type=hidden]').value = '1';
  $(link).closest('.form-group').hide();
}
$(function (){
  function countdown() {
    var now = new Date();
    var eventDate = new Date(2017, 0, 1);
    var currentTime = now.getTime();
    var evenTime = eventDate.getTime();

    var remTime = evenTime - currentTime;

    var sec = Math.floor(remTime / 1000);
    var min = Math.floor(sec / 60);
    var hur = Math.floor(min / 60);
    var day = Math.floor(hur / 24);

      hur %= 24;
      min %= 60;
      sec %= 60;

      hur = (hur < 10) ? "0" + hur : hur;
      min = (min < 10) ? "0" + min : min;
      sec = (sec < 10) ? "0" + sec : sec;

  $('.seconds').text(sec);
  $('.minutes').text(min);
  $('.hours').text(hur);
  $('.days').text(day);

  setTimeout(countdown, 1000);
  }

countdown();
});
