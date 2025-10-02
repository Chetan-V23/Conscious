const AUTH_TOKEN_KEY = 'auth_token';
const USER_DATA_KEY = 'user_data';

const sampleJsonData = {
  "auth_token": "abc123xyz456",
  "name": "Jane Doe",
  "email": "jane.doe@example.com",
  "tasks": [
    {
      "id": "task_001",
      "title": "Buy groceries",
      "description": "Milk, Bread, Eggs, Cheese",
      "dueDate": "2025-04-15T14:00:00.000Z",
      "isCompleted": false
    },
    {
      "id": "task_002",
      "title": "Finish project report",
      "description": "Complete the final section and send it to the manager.",
      "dueDate": "2025-04-20T10:00:00.000Z",
      "isCompleted": true
    }
  ]
};