<template> 
<div class=" bg-gray-100 p-0 sm:p-12">
  <div class="mx-auto max-w-md px-6 py-12 bg-white border-0 shadow-lg sm:rounded-3xl flight-search">
    <h1 class="text-2xl font-bold mb-8">Felhasznalói adatok(Admin)</h1>
    <div id="form" novalidate>
      <div class="relative z-0 w-full mb-5">
        <input type="text" id="search" v-model="searchTerm" @input="searchUsers" placeholder="Keresés felhasználók között" class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200">

        <label for="name" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500"></label>
      </div>

      <div class="relative z-0 w-full mb-5">
        <label for="email" class="absolute duration-300  origin-0 text-gray-500">Jogosultság kiválasztása  <select id="permissions" v-model="selectedPermission" @change="searchUsers">
      <option value="">Mind</option>
      <option v-for="permission in permissions" :value="permission">{{ permission }}</option>
    </select></label>
      </div>
    </div>
  </div>
</div>

  <div class="flex items-center justify-center mb-16 bg-gray-100 ">
    <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-4 xl:grid-cols-4">
        <div v-for="user in megjelenitettuserek" :key="user.id" class="relative bg-white py-6 px-6 rounded-3xl w-64 shadow-xl">
            <div class="mt-8">
                <p class="text-xl font-semibold my-2">{{user.name}}</p>
                <div class="flex space-x-2 text-gray-400 text-sm">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75" />
                   </svg>

                     <p>{{user.email}}</p> 
                </div>
                <div class="flex space-x-2 text-gray-400 text-sm my-3">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                   </svg>
                     <p>Jelszó rejtve</p> 
                </div>
                <div class="border-t-2"></div>

                <div class="flex justify-between">
                    <div class="my-2">
                        <p class="font-semibold text-base mb-2">Jogosultság</p>
                        <div class="flex space-x-2">
                      <p class="font-bold text-gray-600"><button @click="showEditModal(user)">Módosítás</button></p>
                        </div>
                    </div>
                     <div class="my-2">
                        <p class="font-semibold text-base mb-2">{{user.permission}}</p>
                        <div class="text-base text-gray-400 font-semibold">
                            <p class="text-red-400"><button @click="deleteuser(user.id)">Törlés</button></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


  <div id="editModal" class="modal">
    <div class="modal-content">
      <span class="close" @click="hideEditModal">&times;</span>
      <h2>Módosítás</h2>
      <form @submit.prevent="saveChanges">
        <label for="editedName">Név:</label>
        <input type="text" id="editedName" v-model="editeduser.name" required> <br>

        <label for="editedPassword">Jelszó:</label>
        <input type="text" id="editedPassword" v-model="editeduser.password" required><br>

        <label for="editedEmail">Email:</label>
        <input type="text" id="editedEmail" v-model="editeduser.email" required><br>

        <label for="editedPermission">Jogosultság:</label>
        <input type="text" id="editedPermission" v-model="editeduser.permission" required><br>
  
        <button type="submit">Mentés</button>
      </form>
    </div>
  </div>
</template>

<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';

const userek = ref([]);
const megjelenitettuserek = ref([]);
const editeduser = ref({});
const permissions = ref([]);
const users = ref([]);
const selectedPermission = ref('');
const searchTerm = ref('');

onMounted(() => {
  axios.get('https://localhost:7151/api/Useradatok')
  .then(resp => {
      userek.value = resp.data;
      megjelenitettuserek.value = resp.data;
      const uniquePermissions = [...new Set(resp.data.map(user => user.permission))];
      permissions.value = uniquePermissions;
  });
});

const searchUsers = async () => {
try {
  const response = await axios.get('https://localhost:7151/api/Useradatok');
  let filteredUsers = response.data;

  if (selectedPermission.value) {
    filteredUsers = filteredUsers.filter(user => user.permission === selectedPermission.value);
  }

  megjelenitettuserek.value = filteredUsers;

  if (searchTerm.value) {
      const searchTermLowerCase = searchTerm.value.toLowerCase();
      filteredUsers = filteredUsers.filter(user => user.name.toLowerCase().includes(searchTermLowerCase));
    }

    users.value = filteredUsers;

} catch (error) {
  console.error('Hiba történt a felhasználók keresése közben:', error);
}
};


const deleteuser = (id) => {
  axios.delete('https://localhost:7151/api/Useradatok/' + id)
  .then(() => {
    megjelenitettuserek.value = megjelenitettuserek.value.filter(meg => meg.id != id)
  });
};

const showEditModal = (user) => {
  editeduser.value = { ...user };
  const modal = document.getElementById('editModal');
  modal.style.display = 'block';
};

const hideEditModal = () => {
  const modal = document.getElementById('editModal');
  modal.style.display = 'none';
};

const saveChanges = async () => {
  try {
    await axios.put(`https://localhost:7151/api/Useradatok/${editeduser.value.id}`, editeduser.value);
    const index = megjelenitettuserek.value.findIndex(gep => gep.id === editeduser.value.id);
    if (index !== -1) {
      megjelenitettuserek.value[index] = { ...editeduser.value };
    }
    hideEditModal();
  } catch (error) {
    console.error('Hiba történt a változtatások mentése közben:', error);
  }
};
</script>

<style scoped>
.gep-container {
  display: flex;
  flex-wrap: wrap;
}

.gep-card {
  margin: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  width: 200px;
}

.info {
  padding: 10px;
  background-color: #f0f0f0;
  border-bottom: 1px solid #ccc;
  margin: 20px;
}

.info p {
  margin: 5px 0;
  font-weight: bold;
}

.search-container {
  margin-bottom: 20px;
}

.modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 10% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.flight-search {
  max-width: 75%;
  margin: 0 auto;
  margin-top:50px;
}
</style>
