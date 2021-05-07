function new_timeline() {
  /*set up practice block*/
  var practice_block = {
    timeline: [{
      type: 'html-keyboard-response',
      choices: ["arrowleft","arrowup","arrowright"],
      trial_duration: 2000,
      response_ends_trial: true,
      stimulus: jsPsych.timelineVariable('stimulus'),
      data: jsPsych.timelineVariable('data'),
      on_finish: function(data){
        var correct = false;
        if(data.key == data.response && data.rt > -1){
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
