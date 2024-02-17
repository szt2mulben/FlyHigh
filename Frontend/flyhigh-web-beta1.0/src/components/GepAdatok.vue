<template> 

    <table v-for="gepek in gepadatok" :key="gepek.id">
        <tr>
            <td>{{gepek.gepneve}}</td>
            <td>{{gepek.foglaltturista}}</td>
            <td>{{gepek.foglalt1oszt}}</td>
            <td>{{gepek.elsoosztulohelyek}}</td>
            <td>{{gepek.turistaulohelyek}}</td>  
        </tr>
    </table>

</template>

<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';
const gepadatok = ref([]);
onMounted(() => {
    axios.get('https://localhost:7151/api/Gepadatok')
    .then(resp => gepadatok.value = resp.data);
});




</script>