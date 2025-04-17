<script setup>
import { ref } from 'vue';
import { questions, answers } from './data.json';
import Step from './comp/Step.vue';

let index = handlerLocalData();
let question = ref();
let questionLen = ref();
let qFontSize = ref();
let qOpacity = ref();
let nextBtnName = ref('');
let nextBtnDisable = ref();
let prevBtnDisable = ref();
let answer = ref('');
let answerBtnDisable = ref();
let answerHidden = ref();
let stepRefA = ref();
let stepRefB = ref();
let stepRefC = ref();
let stepRefD = ref();
let stepRefE = ref();
init();

function init () {
  if(index < 0) return reset();
  question.value = questions[index];
  questionLen.value = questions.length - index - 1;
  qFontSize.value = 10;
  qOpacity.value = 1;
  nextBtnName.value = '下一题';
  nextBtnDisable.value = !Boolean(questionLen.value);
  prevBtnDisable.value = !Boolean(index > 0);
  answer.value = answers[index];
  answerHidden.value = true;
  answerBtnDisable.value = false;
}

function reset () { 
  index = handlerLocalData(-1);
  question.value = '请“开始”';
  questionLen.value = questions.length;
  qFontSize.value = 10;
  qOpacity.value = 1;
  nextBtnName.value = '开始';
  nextBtnDisable.value = false;
  prevBtnDisable.value = true;
  answer.value = '';
  answerHidden.value = true;
  answerBtnDisable.value = true;
}

async function nextQuestion() {
  if(nextBtnName.value === '开始') {
    nextBtnName.value = '下一题';
    answerBtnDisable.value = true;
  }
  if(++index == questions.length-1) nextBtnDisable.value = true;
  if(index) prevBtnDisable.value = false;
  question.value = questions[index];
  questionLen.value = questionLen.value - 1;
  qFontSize.value = 10;
  qOpacity.value = 1;
  answer.value = answers[index];
  answerHidden.value = true;
  answerBtnDisable.value = false;
  handlerLocalData(index);
}

async function prevQuestion() {
  nextBtnDisable.value = false;
  if(--index == 0) prevBtnDisable.value = true;
  question.value = questions[index];
  questionLen.value = questionLen.value + 1;
  qFontSize.value = 10;
  qOpacity.value = 1;
  answer.value = answers[index];
  answerHidden.value = true;
  answerBtnDisable.value = false;
  handlerLocalData(index);
}

async function showAnswer () {
  answerHidden.value = !answerHidden.value;
  qFontSize.value = answerHidden.value ? 10 : 5;
  qOpacity.value = answerHidden.value ? 1 : 0.6;
}

async function stepHandle() {
  stepRefA.value.add();
  stepRefB.value.add();
  stepRefC.value.add();
  stepRefD.value.add();
  stepRefE.value.add();
}

function handlerLocalData (data) {
  const key = 'question_index';
  if(typeof data === 'number') {
    localStorage.setItem(key, data);
    return data;
  }
  const ldata = localStorage.getItem(key);
  if(ldata) return ldata;
  return -1;
}
</script>

<template>
  <main>
    <div class="score">
      <button @click="stepHandle()">All +</button>
      <h2>A组: <Step name="scoreA" ref="stepRefA"/></h2>
      <h2>B组: <Step name="scoreB" ref="stepRefB"/></h2>
      <h2>C组: <Step name="scoreC" ref="stepRefC"/></h2>
      <h2>D组: <Step name="scoreD" ref="stepRefD"/></h2>
      <h2>E组: <Step name="scoreE" ref="stepRefE"/></h2>
    </div>
    <h1 :style="{fontSize: qFontSize + 'vw', opacity: qOpacity}">{{ question }}</h1>
    <h1 :hidden='answerHidden'>{{ answer }}</h1>
    <div class="foot">
      <button class="resetBtn" @click="prevQuestion()" :disabled='prevBtnDisable'>上一题</button>
      <button class="startBtn" @click="nextQuestion()" :disabled='nextBtnDisable'>{{ nextBtnName }}</button>
      <button class="answerBtn" @click="showAnswer()" :disabled='answerBtnDisable'>答案</button>
      <div class="reset">
        <p>剩余题数：{{questionLen}}</p>
        <button class="resetBtn" @click="reset()" >重置</button>
      </div>
    </div>
  </main>
</template>

<style scoped>
main {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: inherit;
  justify-content: space-evenly;
  width: 100%;
  height: 100%;
}

.score {
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
  align-items: center;
  width: 100%;
}

.score button {
  width: 50px;
  height: 30px;
}

.foot {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  width: 60%;
  justify-content: space-around;
}

.reset {
  display: flex;
  flex-direction: column;
  align-items: center;
}

h1 {
  font-size: 10vw; 
  user-select: none;
  width: 100%;
  text-align: center;
}

.startBtn {
    background-color: orangered;
    color: white;
    font-size: x-large;
    width: 120px;
    height: 50px;
    font-weight: bold;
    letter-spacing: 5px;
}

.answerBtn {
  background-color: cadetblue;
  color: white;
  font-size: x-large;
  width: 120px;
  height: 50px;
  font-weight: bold;
  letter-spacing: 5px;
}

.resetBtn {
  width: 80px;
  height: 40px;
  font-size: large;
  letter-spacing: 3px;
}
</style>