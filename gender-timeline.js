function new_timeline() {
  /* defining test timeline*/
  var gend = ["Mujer ", "Hombre ", "Género no binario / Otro ", "Prefiero no contestar "];

  var y_n = ["Sí ", "No ", "Prefiero no contestar "];

  var gender = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "Por favor indique su género.", name: 'Gender', options: gend, required: true},
        {prompt: "¿Su género coincide con el que le asignaron al nacer?", name: 'CisTrans', options: y_n, required: true}
      ],
      post_trial_gap: 500
  }],
  // timeline_variables: gend, y_n,
  // sample: {type: 'fixed-repetitions', size: 1}
};
return [gender];
}
