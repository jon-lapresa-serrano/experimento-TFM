function new_timeline() {
  /* defining test timeline*/
  var thanks = {
    timeline: [{
      type: "html-button-response",
      choices: ['Finalizar'],
      stimulus: jsPsych.timelineVariable('stimulus'),
      post_trial_gap: 500
  }],
  timeline_variables: thanks_text,
  sample: {type: 'fixed-repetitions', size: 1}
};
return [thanks];
}
