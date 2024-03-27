<template> 
  <h1>Felhasznalói adatok(Admin)</h1>
  <div class="search-container">
    <label for="search">Keresés felhasználók között:</label>
    <input type="text" id="search" v-model="searchTerm" @input="searchUsers">
    <div>
    <label for="permissions">Jogosultság kiválasztása:</label>
    <select id="permissions" v-model="selectedPermission" @change="searchUsers">
      <option value="">Mind</option>
      <option v-for="permission in permissions" :value="permission">{{ permission }}</option>
    </select>
  </div>
  </div>
  <div class="gep-container">
    <div v-for="user in megjelenitettuserek" :key="user.id" class="gep-card">
      <div class="info">
        <p><span>Név:</span> {{user.name}}</p>
        <p><span>Jelszó:</span> ********</p>
        <p><span>Email:</span> {{user.email}}</p>
        <p><span>Jogosultság:</span> {{user.permission}}</p>
        <p>
          <button @click="deleteuser(user.id)">Törlés</button>
          <button @click="showEditModal(user)">Módosítás</button>
        </p> 
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
</style>
