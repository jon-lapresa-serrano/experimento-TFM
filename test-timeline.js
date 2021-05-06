function new_timeline() {
  /* defining test timeline*/
  var test = {
    timeline: [{
      type: 'html-keyboard-response',
      choices: ["ArrowLeft","ArrowUp","ArrowRight"],
      trial_duration: 2000,
      response_ends_trial: true,
      stimulus: jsPsych.timelineVariable('stimulus'),
      data: jsPsych.timelineVariable('data'),
      on_finish: function(data){
        var correct = false;
        if(data.key == 'ArrowLeft' &&  data.response == 37 && data.rt > -1){
          correct = true;
        } else if(data.key == 'ArrowUp' &&  data.response == 38 && data.rt > -1){
          correct = true;
        } else if(data.key == 'ArrowRight' &&  data.response == 39 && data.rt > -1){
          correct = true;
        }
        data.correct = correct;
      },
      post_trial_gap: function() {
          return Math.floor(Math.random() * 1500) + 500;
      }
    }],
    timeline_variables: test_stimuli,
    // sample: {type: 'fixed-repetitions', size: reps_per_trial_type}
    randomize_order: true,
    repetitions: 1
  };
  return [test];
}
