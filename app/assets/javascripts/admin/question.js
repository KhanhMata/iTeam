$(document).ready(function() {
  render_question_answer_type();

  $(document).on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).parent().append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

  $(document).on('click', '.remove_fields', function(event) {
    $(this).parent().prev('input[answer_type=hidden]').val('true');
    $(this).closest('.answer-field-box').hide();
    return event.preventDefault();
  });

  $('#question_question_answer_type').on('change', function(){
    render_question_answer_type();
  });

  $('#new_question').on('submit', function(event) {
    event.preventDefault();
    var answer_type = $('#question_question_answer_type').val();
    if (answer_type === 'text'){
      $('#single-choice-question .destroy-choice').val('true');
      $('#multiple-choice-question .destroy-choice').val('true');
    }
    else if (answer_type === 'single_choice'){
      $('#text-question .destroy-choice').val('true');
      $('#multiple-choice-question .destroy-choice').val('true');
    }
    else {
      $('#text-question .destroy-choice').val('true');
      $('#single-choice-question .destroy-choice').val('true');
    }
    this.submit();
  });

  $(document).on('click', '.answer-option', function(event){
    if ($(this).attr('answer_type') === 'radio') {
      $('#single-choice-question .answer-option').prop('checked', '');
      $('#single-choice-question .hidden_for_answer').val('false');
    }
    $(this).prop('checked', 'checked');
    $(this).next().val('true');
  })
});

function render_question_answer_type(){
  var answer_type = $('#question_question_answer_type').val();
  if (answer_type === 'text'){
    $('#text-question').removeClass('hidden');
    $('#single-choice-question').addClass('hidden');
    $('#multiple-choice-question').addClass('hidden');
  }
  else if (answer_type === 'single_choice'){
    $('#text-question').addClass('hidden');
    $('#single-choice-question').removeClass('hidden');
    $('#multiple-choice-question').addClass('hidden');
  }
  else {
    $('#text-question').addClass('hidden');
    $('#single-choice-question').addClass('hidden');
    $('#multiple-choice-question').removeClass('hidden');
  }
}
