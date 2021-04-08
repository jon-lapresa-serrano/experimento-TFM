function new_timeline() {
  /* defining test timeline*/
  var lang1 = {
    timeline: [{
      type: "survey-text",
      questions: [
        {prompt: "Por favor indique su idioma de comunicación principal.", name: 'Language1', required: true},
        {prompt: "Por favor indique a qué edad adquirió el español (escriba un cero si es desde el nacimiento).", name: 'AoA', required: true}
      ],
      post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [lang1];
}
