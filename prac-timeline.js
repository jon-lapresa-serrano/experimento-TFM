function new_timeline() {
  /*set up practice block*/
  var practice_block = {
    timeline: [{
      type: 'html-keyboard-response',
      choices: ["ArrowLeft","ArrowUp","ArrowRight"],
      trial_duration: 2000,
      response_ends_trial: true,
      stimulus: jsPsych.timelineVariable('stimulus'),
      data: jsPsych.timelineVariable('data'),
      on_finish: function(data){
        var correct = false;
        if(data.response == 'ArrowLeft' &&  data.key_press == 37 && data.rt > -1){
          correct = true;
        } else if(data.response == 'ArrowUp' &&  data.key_press == 38 && data.rt > -1){
          correct = true;
        } else if(data.response == 'ArrowRight' &&  data.key_press == 39 && data.rt > -1){
          correct = true;
        }
        data.correct = correct;
      },
      post_trial_gap: function() {
          return Math.floor(Math.random() * 1500) + 500;
      }
    }],
    timeline_variables: prac_stimuli,
    // sample: {type: 'fixed-repetitions', size: 1}
    randomize_order: true,
    repetitions: 1
  };
  return [practice_block];
}
