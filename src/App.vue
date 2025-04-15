<script setup>
import { ref, nextTick } from 'vue';
import { questions, answers } from './data.json';

let index = handlerLocalData(-1);
let question = ref('');
let questionLen = ref();
let qFontSize = ref();
let qOpacity = ref();
let btnName = ref('');
let nextBtnDisable = ref();
let prevBtnDisable = ref();
let answer = ref('');
let answerBtnDisable = ref();
let answerHidden = ref();
reset();

async function reset () { 
  index = handlerLocalData(-1);
  questionLen.value = questions.length;
  question.value = '请“开始”';
  qFontSize.value = 10;
  qOpacity.value = 1;
  btnName.value = '开始';
  nextBtnDisable.value = false;
  prevBtnDisable.value = true;
  answerHidden.value = true;
  answerBtnDisable.value = true;
}

async function nextQuestion() {
  if(btnName.value === '开始') {
    btnName.value = '下一题';
    answerBtnDisable.value = true;
  }
  if(++index == questions.length-1) nextBtnDisable.value = true;
  if(index) prevBtnDisable.value = false;
  question.value = questions[index];
  questionLen.value = questionLen.value - 1;
  qFontSize.value = 10;
  qOpacity.value = 1;
  answerHidden.value = true;
  answerBtnDisable.value = false;
  answer.value = answers[index];
}

async function prevQuestion() {
  if(--index == 0) prevBtnDisable.value = true;
  question.value = questions[index];
  questionLen.value = questionLen.value + 1;
  qFontSize.value = 10;
  qOpacity.value = 1;
  answerHidden.value = true;
  answerBtnDisable.value = false;
  answer.value = answers[index];
}

async function showAnswer () {
  answerHidden.value = !answerHidden.value;
  qFontSize.value = answerHidden.value ? 10 : 5;
  qOpacity.value = answerHidden.value ? 1 : 0.6;
}

function handlerLocalData (data) {
  const key = 'question_index';
  if(typeof data === 'number') {
    localStorage.setItem(key, data);
    return data;
  }
  const ldata = localStorage.getItem(key);
  if(ldata) return ldata;
}
</script>

<template>
  <main>
    <h1 :style="{fontSize: qFontSize + 'vw', opacity: qOpacity}">{{ question }}</h1>
    <h1 :hidden='answerHidden'>{{ answer }}</h1>
    <div class="foot">
      <button class="resetBtn" @click="prevQuestion()" :disabled='prevBtnDisable'>上一题</button>
      <button class="startBtn" @click="nextQuestion()" :disabled='nextBtnDisable'>{{ btnName }}</button>
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