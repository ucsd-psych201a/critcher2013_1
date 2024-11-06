document.addEventListener("DOMContentLoaded", function() {
    const timeline = [];

    // Story conditions
    const storyMoral = {
        type: "html-button-response",
        stimulus: `
            <p>Justin and Nate each found a wallet with cash. Justin quickly decided to return the wallet, while Nate took some time but also returned it.</p>
        `,
        choices: ['Continue']
    };

    const storyImmoral = {
        type: "html-button-response",
        stimulus: `
            <p>Justin and Nate each found a wallet with cash. Justin quickly decided to take the cash, while Nate took some time but also took it.</p>
        `,
        choices: ['Continue']
    };

    // Questionnaire for Justin
    const questionsJustin = [
        {
            type: "survey-likert",
            questions: [
                { prompt: "Did Justin make his decision quickly or slowly?", labels: ["Particularly slowly", "", "", "", "", "", "Particularly quickly"], required: true }
            ]
        },
        {
            type: "survey-likert",
            questions: [
                { prompt: "Does it sound like Justin has underlying moral principles that are good, bad, or somewhere in between?", labels: ["Completely bad", "", "", "Mixed", "", "", "Completely good"], required: true },
                { prompt: "Does Justin have the moral knowledge to do ‘the right thing’?", labels: ["Not at all", "", "", "Somewhat", "", "", "Completely"], required: true }
            ]
        },
    ];

    // Questionnaire for Nate
    const questionsNate = [
        {
            type: "survey-likert",
            questions: [
                { prompt: "Did Nate make his decision quickly or slowly?", labels: ["Particularly slowly", "", "", "", "", "", "Particularly quickly"], required: true }
            ]
        },
        {
            type: "survey-likert",
            questions: [
                { prompt: "Does it sound like Nate has underlying moral principles that are good, bad, or somewhere in between?", labels: ["Completely bad", "", "", "Mixed", "", "", "Completely good"], required: true },
                { prompt: "Does Nate have the moral knowledge to do ‘the right thing’?", labels: ["Not at all", "", "", "Somewhat", "", "", "Completely"], required: true }
            ]
        },
    ];

    // Adding conditions to timeline
    const condition = Math.random() > 0.5 ? 'moral' : 'immoral';
    if (condition === 'moral') {
        timeline.push(storyMoral, ...questionsJustin, ...questionsNate);
    } else {
        timeline.push(storyImmoral, ...questionsJustin, ...questionsNate);
    }

    // Initialize jsPsych experiment
    jsPsych.init({
        timeline: timeline,
        display_element: 'jspsych-target',
        on_finish: function() {
            jsPsych.data.displayData();
        }
    });
});
