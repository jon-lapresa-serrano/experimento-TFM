function new_timeline() {
  /* defining test timeline*/
  var instr1 = {
    timeline: [{
      type: "html-button-response",
      choices: ['Continuar'],
      stimulus: jsPsych.timelineVariable('stimulus'),
      post_trial_gap: 500
  }],
  timeline_variables: instr_text,
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr1];
}
