
/* initialise */
var timeline=[];
var introloop=[];
var testorder = jsPsych.randomization.shuffle([2, 3, 4, 5, 6, 7, 8]); // omit test item 1 in this version!
var condition = jsPsych.randomization.shuffle(["category","property"])[0];
var baserate = jsPsych.randomization.shuffle(["small","large"])[0];
var turkcode = (Math.floor(Math.random() * 899999) + 100000).toString(); // generate completion code
    
    
/* function to end of the experiment */
function endExperiment(dataset, callback) {
  // $.post('submit',{"content": dataset});
  setTimeout(callback,1000);
}
    
/* function to start the experiment */
function startExperiment(){
  
  //document.getElementById("splash").style.display = "none";
  jsPsych.init({
    timeline: timeline,
    preload_images: images,
    on_finish: function() {
      endExperiment( jsPsych.data.dataAsCSV(), function() {
        document.write('<div id="endscreen" class="endscreen" style="width:1000px"><div class="endscreen" style="text-align:center; border:0px solid; padding:10px; font-size:120%; width:800px; float:right"><p><br><br><br>All done!<br><br>Your completion code is <span id="turkcode" style="font-weight:bold;font-size:130%">' + turkcode + '</span>. Thank you for participating!</p></div></div>');
      });
    }
  });
}
    
// -------------------- main expt ----------------
      
/* function that generates test string */
function testString(ind) {
  var str;
  str = "<img src='./img/test" + ind + ".jpg' width=800px><p width=800px><span id='qqqqq' style='display:none'>In your opinion, how likely is it that a Sodor sphere of this size has a plaxium coating?</span></p>";
  return(str);
}
    
    
/* define setup block */
var setup_block = {
  type: 'button-response',
  timing_post_trial: 0,
  button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
  choices: ['Click here to continue'],
  on_trial_start: function() { setTimeout(function() {setDisplay("jspsych-btn","")}, 3000)},
  is_html: true,
  timeline: [
    {stimulus: '<img src="./img/robot1.jpg" width=800px>'},
    {stimulus: '<img src="./img/robot2.jpg" width=800px>'},
    {stimulus: '<img src="./img/robot3.jpg" width=800px>'},
    {stimulus: '<img src="./img/robot6.jpg" width=800px>'},
    {stimulus: '<img src="./img/robot7.jpg" width=800px>'},
    {stimulus: '<img src="./img/robot8_' + condition + '.jpg" width=800px>'},
    {stimulus: '<img src="./img/robot9_' + condition + '.jpg" width=800px>'},
    {stimulus: '<img src="./img/robot10_' + condition + '.jpg" width=800px>'}
    ]
};
introloop.push(setup_block);
      
      
/* define instruction check block */
var instructioncorrect = false;
var q3a;
if(condition == "category") {
  q3a = [" Yes, it checks every sphere it encounters"," No, it only tests the small spheres"];
} else {
  q3a = [" Yes, it checks every sphere it encounters"," No, it only tests spheres with the plaxium coating"];
}

var instruction_check = {
  type: "survey-multi-choice",
  preamble: ["<p align='center'><b>Check your knowledge before you begin!</b></p>"],
  questions: ["<b>Question 1</b>: What is your goal in this task?", "<b>Question 2</b>: Which is true about the size of Sodor spheres?","<b>Question 3</b>: Does the probe transmit data about any sphere it encounters?"],
  randomize_order: true,
  options: [[" To find out if the planet Sodor is made of cheese"," To find out which Sodor spheres have plaxium coatings"],jsPsych.randomization.shuffle(["Spheres on Sodor come in a variety of sizes", "Spheres on Sodor are always small", "Spheres on Sodor are always large"]),q3a],
  on_finish: function(data) {
    if(condition == "category") {
      if(data.responses == '{"Q0":" To find out which Sodor spheres have plaxium coatings","Q1":"Spheres on Sodor come in a variety of sizes","Q2":" No, it only tests the small spheres"}') {
        action = false;
        instructioncorrect = true;
      }
    }
    if(condition == "property") {
      if(data.responses == '{"Q0":" To find out which Sodor spheres have plaxium coatings","Q1":"Spheres on Sodor come in a variety of sizes","Q2":" No, it only tests spheres with the plaxium coating"}') {
        action = false;
        instructioncorrect = true;
      }
    }
  }
};
introloop.push(instruction_check);
        
var showsplash = true;
var splash_screen = {
  type: 'button-response',
  timing_post_trial: 0,
  button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
  choices: ['Click here to read the instructions again'],
  on_trial_start: function() { setTimeout(function() {setDisplay("jspsych-btn","")}, 1000)},
  is_html: true,
  stimulus: '<img src = "./img/instructionfail.jpg" width=800px>'
};

var conditional_splash = {
  timeline: [splash_screen],
  conditional_function: function(data) {
    return !instructioncorrect; // skip if correct
  }
};
introloop.push(conditional_splash);

var loop_node = {
  timeline: introloop,
  loop_function: function(data) {
    //var action = true;
    return !instructioncorrect; // stop looping if correct
  }
};
timeline.push(loop_node);
        
        
/* success trial */
  var successtrial = {
    type: 'button-response',
    timing_post_trial: 0,
    button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
    choices: ['Click here to begin the mission'],
    on_trial_start: function() { setTimeout(function() {setDisplay("jspsych-btn","")}, 1000)},
    is_html: true,
    timeline: [
      {stimulus: '<img src = "./img/instructionsuccess_' + condition + '.jpg" width=800px>'},
      {stimulus: '<img src = "./img/dataX_' + condition + '.jpg" width=800px>'}
      ]
  };
timeline.push(successtrial);

// function to change the display property of a set of objects
function setDisplay(theClass, theValue) {
  var i, classElements = document.getElementsByClassName(theClass);
  for (i = 0; i < classElements.length; i = i + 1) {
    classElements[i].style.display = theValue;
  }
}
        
        
/* define observation trial */
  var arrivalprompt;
if(condition == "property") {
  arrivalprompt = "The probe has detected a sphere with plaxium: Click here to view";
} else {
  arrivalprompt = "The probe has found and tested a small sphere: Click here to view";
}
var waitprompt = "<p align='center' style='color:white'>...</p>";

var obs_block1 = {
  type: 'button-response',
  timing_post_trial: 0,
  button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
  on_trial_start: function() { setTimeout(function() {setDisplay("jspsych-btn","")}, (Math.random() * 3000) + 3000)},
  is_html: true,
  timeline: [
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data0_' + condition + '.jpg" width=800px>'},
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data1_' + condition + '.jpg" width=800px>'},
    {choices: ['Click here to continue.'], stimulus: '<img src = "./img/data2_' + condition + '.jpg" width=800px>'},
    
    ]
};

var obs_block2 = {
  type: 'button-response',
  timing_post_trial: 0,
  button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
  on_trial_start: function() { setTimeout(function() {setDisplay("jspsych-btn","")}, (Math.random() * 800) + 800)},
  is_html: true,
  timeline: [
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data2_' + condition + '.jpg" width=800px>'}, //this is skipped over
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data3_' + condition + '.jpg" width=800px>'},
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data4_' + condition + '.jpg" width=800px>'},
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data5_' + condition + '.jpg" width=800px>'},
    {choices: ['Click here to continue.'], stimulus: '<img src = "./img/data6_' + condition + '.jpg" width=800px>'},
  ]
};
        
var obs_block3 = {
  type: 'button-response',
  timing_post_trial: 0,
  button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
  on_trial_start: function() { setTimeout(function() {setDisplay("jspsych-btn","")}, (Math.random() * 800) + 800)},
  is_html: true,
  timeline: [
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data6_' + condition + '.jpg" width=800px>'}, //this is skipped over
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data7_' + condition + '.jpg" width=800px>'},
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data8_' + condition + '.jpg" width=800px>'},
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data9_' + condition + '.jpg" width=800px>'},
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data10_' + condition + '.jpg" width=800px>'},
    {choices: [arrivalprompt], stimulus: '<img src = "./img/data11_' + condition + '.jpg" width=800px>'},
    {choices: ['Click here to continue.'], stimulus: '<img src = "./img/data12_' + condition + '.jpg" width=800px>'}
  ]
};
        
/* define interim block */
var interim_block = {
  type: 'button-response',
  timing_post_trial: 0,
  button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
  choices: ['Click here to continue'],
  on_trial_start: function() { setTimeout(function() {setDisplay("jspsych-btn","")}, 2000)},
  is_html: true,
  timeline: [
    {stimulus: '<img src = "./img/interim1_' + condition + '.jpg" width=800px>'}
  ]
};
        
/* define test block */
var test_block = {
  type: 'button-response',
  choices: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
  timing_post_trial: 500,
  button_html: '<button class="jspsych-btn" style="display:none">%choice%</button>',
  randomize_order: true, // <- HM.
  prompt: "<p class='center-content'><span id='zzzzz' style='display:none'>[1 = Definitely does not] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; [10 = Definitely does]</span></p>",
  is_html: true,
  on_trial_start: function() { setTimeout(function() {document.getElementById("zzzzz").style.display = ""; document.getElementById("qqqqq").style.display = ""; setDisplay("jspsych-btn","")}, 1000)},
  timeline: [
    {stimulus: testString(testorder[0])},
    {stimulus: testString(testorder[1])},
    {stimulus: testString(testorder[2])},
    {stimulus: testString(testorder[3])},
    {stimulus: testString(testorder[4])},
    {stimulus: testString(testorder[5])},
    {stimulus: testString(testorder[6])}
  ]
};
        
/* observation + test */
timeline.push(obs_block1);
timeline.push(interim_block);
timeline.push(test_block);

/* observation + test */
timeline.push(obs_block2);
timeline.push(interim_block);
timeline.push(test_block);

/* observation + test */
timeline.push(obs_block3);
timeline.push(interim_block);
timeline.push(test_block);
        
        
/* image list */
var images = [
  './img/robot1.jpg',
  './img/robot2.jpg',
  './img/robot3_' + baserate + '.jpg',
  './img/robot4_' + baserate + '.jpg',
  './img/robot5_' + baserate + '.jpg',
  './img/robot6.jpg',
  './img/robot7.jpg',
  './img/robot8_' + condition + '.jpg',
  './img/robot9_' + condition + '.jpg',
  './img/robot10_' + baserate + '_' + condition + '.jpg',
  './img/instructionfail.jpg',
  './img/instructionsuccess_' + baserate + '_' + condition + '.jpg',
  './img/data0_' + baserate + '_' + condition + '.jpg',
  './img/data1_' + baserate + '_' + condition + '.jpg',
  './img/data2_' + baserate + '_' + condition + '.jpg',
  './img/data3_' + baserate + '_' + condition + '.jpg',
  './img/data4_' + baserate + '_' + condition + '.jpg',
  './img/data5_' + baserate + '_' + condition + '.jpg',
  './img/data6_' + baserate + '_' + condition + '.jpg',
  './img/data7_' + baserate + '_' + condition + '.jpg',
  './img/data8_' + baserate + '_' + condition + '.jpg',
  './img/data9_' + baserate + '_' + condition + '.jpg',
  './img/interim1_' + condition + '.jpg',
  './img/interim2_' + baserate + '_' + condition + '.jpg',
  './img/interim3_' + baserate + '_' + condition + '.jpg',
  './img/test1.jpg',
  './img/test2.jpg',
  './img/test3.jpg',
  './img/test4.jpg',
  './img/test5.jpg',
  './img/test6.jpg',
  './img/test7.jpg',
  './img/test8.jpg'
];
        
        
startExperiment();
        
        