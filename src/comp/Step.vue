<script setup>
  import { ref, watch } from 'vue';
  
  const props = defineProps({
    name: { 
      type: String,
      // default: Math.random(),
      required: true
    }
  })
  
  let count = ref(handlerLocalData());

  function add (num=1) {
    count.value += num;
  }

  defineExpose({
    add
  });

  watch (count, (newValue) => {
    handlerLocalData(newValue);
  });

  function handlerLocalData (data) {
    const key = 'step-'+props.name;
    if(typeof data === 'number') {
      localStorage.setItem(key, data);
      return data;
    }
    const ldata = localStorage.getItem(key);
    return ldata && Number(ldata) || 0;
  }

</script>

<template>
  <button @click="count--">-</button>
    <span class="num">{{ count }}</span>
  <button @click="count++">+</button>
</template>

<style scoped>
button {
  width: 40px;
  height: 40px;
  background: none;
  font-size: x-large;
}

.num {
  color: red;
  font-weight: bold;
}
</style>