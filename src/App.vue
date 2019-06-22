<template>
  <div id="app">
    <div class="header">
      <span class="header__title">Todooooooo</span>
      <button role="button" class="header__add-btn" @click="addTodoDialogVisible = true">
        <span class="mdi mdi-plus"></span>
      </button>
    </div>
    <div class="todo-list">
      <div v-for="(todo, index) in todos" :key="`todo-${index}`" class="todo-list__item">
        <input
          :checked="todo.completed"
          @change="changeTodoStatus(index, $event.target.checked)"
          class="todo-item__checkbox"
          :id="`cb-${index}`"
          type="checkbox"
        >
        <label :for="`cb-${index}`"></label>
        <span class="todo-item__text">{{ todo.text }}</span>
        <button role="button" class="todo-item__delete-btn" @click="removeTodo(index)">
          <span class="mdi mdi-delete"></span>
        </button>
      </div>
    </div>
    <div v-if="addTodoDialogVisible" class="add-todo-dialog">
      <div class="add-todo-dialog__card">
        <input
          v-model="addTodoText"
          class="add-todo-dialog__input"
          type="text"
          placeholder="請輸入待辦事項"
          @keydown.enter="addTodo"
        >
        <div class="dialog-buttons">
          <button class="dialog-buttons__confirm-btn" :disabled="!addTodoText" @click="addTodo">確認</button>
          <button class="dialog-buttons__cancel-btn" @click="cancelDialog">取消</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'app',
  data () {
    return {
      addTodoDialogVisible: false,
      addTodoText: '',
      todos: JSON.parse(localStorage.getItem('todos')) || []
    }
  },
  methods: {
    saveToLocalStorage () {
      localStorage.setItem('todos', JSON.stringify(this.todos))
    },
    addTodo () {
      this.todos.push({
        text: this.addTodoText,
        completed: false
      })
      this.addTodoDialogVisible = false
      this.addTodoText = ''
      this.saveToLocalStorage()
    },
    removeTodo (todoObjectIndex) {
      this.todos.splice(todoObjectIndex, 1)
      this.saveToLocalStorage()
    },
    changeTodoStatus (todoObjectIndex, newStatus) {
      console.log(newStatus)
      this.todos[todoObjectIndex].completed = newStatus
      this.saveToLocalStorage()
    },
    cancelDialog () {
      this.addTodoDialogVisible = false
      this.addTodoText = ''
    }
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  line-height: 1;
}

#app {
  font-family: Helvetica, Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "黑體-繁",
    "Heiti TC", "微軟正黑體", "Microsoft JhengHei", sans-serif;
}

.header {
  height: 120px;
  background: #2196f3;
  color: #ffffff;
  display: flex;
  align-items: center;
  padding: 24px;
}

.header__title {
  display: inline-block;
  font-size: 10vmin;
  font-size: 900;
}

.header__add-btn {
  margin: auto 0 auto auto;
  padding: 8px 16px;
  display: inline-block;
  border: 2px solid #ffffff;
  border-radius: 20px;
  background: transparent;
  outline: none;
  color: #ffffff;
  font-size: 1.25rem;
  cursor: pointer;
}

button:active {
  transform: scale(0.95);
}

button:disabled {
  color: #777777;
  border-color: #777777;
  opacity: 0.7;
}

.todo-list {
  max-width: 700px;
  padding: 16px;
  margin: auto;
}

.todo-list__item {
  height: 70px;
  margin: 8px 0;
  padding: 16px;
  border-radius: 5px;
  box-shadow: 0px 0px 4px #aaaaaa;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.todo-item__checkbox {
  display: none;
}

.todo-item__checkbox + label {
  visibility: hidden;
  display: inline-block;
  width: 20px;
  height: 20px;
  background: transparent;
  border: 2px solid #777777;
  border-radius: 5px;
}

.todo-item__checkbox:checked + label {
  background: #4baeff;
}

.todo-item__checkbox:checked ~ .todo-item__text {
  text-decoration: line-through;
}

.todo-item__text {
  display: inline-block;
  width: calc(100% - 180px);
  max-height: 100%;
  font-size: 1.5rem;
  color: #555555;
  overflow: hidden;
}

.todo-item__delete-btn {
  visibility: hidden;
  padding: 8px 16px;
  display: inline-block;
  font-size: 1.25rem;
  border: 1px solid #ff3d3d;
  border-radius: 20px;
  background: transparent;
  outline: none;
  color: #ff3d3d;
  cursor: pointer;
}

.todo-list__item:hover .todo-item__delete-btn,
.todo-list__item:hover .todo-item__checkbox + label {
  visibility: visible;
}

.add-todo-dialog {
  display: flex;
  justify-content: center;
  align-items: center;
  position: absolute;
  top: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.25);
}

.add-todo-dialog__card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 250px;
  padding: 16px;
  background: #ffffff;
  border-radius: 5px;
}

.add-todo-dialog__input {
  display: inline-block;
  width: 100%;
  height: 40px;
  outline: none;
  padding: 8px;
  font-size: 18px;
}

.dialog-buttons {
  margin-top: 30px;
  display: flex;
  justify-content: space-around;
  width: 100%;
}

.dialog-buttons__cancel-btn {
  padding: 8px 16px;
  display: inline-block;
  border: 1px solid #ff3d3d;
  border-radius: 20px;
  background: transparent;
  outline: none;
  color: #ff3d3d;
  cursor: pointer;
}

.dialog-buttons__confirm-btn {
  padding: 8px 16px;
  display: inline-block;
  border: 1px solid #2196f3;
  border-radius: 20px;
  background: transparent;
  outline: none;
  color: #2196f3;
  cursor: pointer;
}
</style>
