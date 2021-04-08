function new_timeline() {
  /* defining test timeline*/
  var demographics = {
    timeline: [{
      type: "survey-text",
      questions: [
        {prompt: "Por favor indique su edad.", name: 'Age', required: true},
        {prompt: "Por favor indique de qué país es usted.", name: 'Nationality', required: true},
        {prompt: "Por favor indique su país de residencia actual", name: 'Residence', required: true}
      ],
      post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [demographics];
}
