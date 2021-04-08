function new_timeline() {
  /* defining test timeline*/
  var edu = ["Educación primaria ", "Educación secundaria ", "Bachillerato ", "Grado universitario ", "Máster ", "Doctorado ", "Otro "];

  var education = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "Por favor indique su nivel más alto de formación académica completada.", name: 'Education', options: edu, required: true}
      ],
      post_trial_gap: 500
  }],
  // timeline_variables: edu,
  // sample: {type: 'fixed-repetitions', size: 1}
};
return [education];
}
