<?php

declare(strict_types=1);

// 1. Опишите, какие проблемы могут возникнуть при использовании данного кода
$mysqli = new mysqli('localhost', 'my_user', 'my_password', 'world');
$id = $_GET['id'];
$res = $mysqli->query('SELECT * FROM users WHERE u_id=' . $id);
$user = $res->fetch_assoc();
// 1. Из очевидного SQL инъекция
// 2. нет проверки наличия id
// 3. Нужна проверка на ошибки при запросе к бд


//2. Сделайте рефакторинг
...
$questionsQ = $mysqli->query('SELECT * FROM questions WHERE catalog_id='. $catId);
$result = array();
while ($question = $questionsQ->fetch_assoc()) {
    $userQ = $mysqli->query('SELECT name, gender FROM users WHERE id='. (int)$question[‘user_id’]);
    $user = $userQ->fetch_assoc();
    $result[] = array('question'=>$question, 'user'=>$user);
    $userQ->free();
}
$questionsQ->free();

// -------------------------

$query = 'SELECT q.*, u.name, u.gender 
          FROM questions AS q 
          INNER JOIN users AS u ON q.user_id = u.id 
          WHERE q.catalog_id = ?';

$stmt = $mysqli->prepare($query);

if ($stmt) {
    $stmt->bind_param('i', $catId);
    $stmt->execute();

    $result = $stmt->get_result();

    $questions = array();
    while ($row = $result->fetch_assoc()) {
        $questions[] = array(
            'question' => $row,
            'user' => array(
                'name' => $row['name'],
                'gender' => $row['gender']
            )
        );
    }

    $result->free();

    $stmt->close();
}


