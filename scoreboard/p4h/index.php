<?php

ini_set('log_errors', 1);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header('Cache-Control: no-cache');

function process_post() {
  $raw = file_get_contents('php://input');
  file_put_contents('./data/debug.yaml', $raw); #D
  $data = yaml_parse($raw);
  if ($data['nickname'] and $data['secret']) {
    if (file_exists('./db/'.$data['nickname'])) {
      $secret = unserialize(file_get_contents('./db/'.$data['nickname']));
      if ($secret != $data['secret']) {
        header("HTTP/1.1 403 Forbidden: bad user.");
        print "bad user.";
        die;
      #} else {
      #  print "auth ok: ".$secret." === ".$data['secret'];
      }
    } else {
      # new user
      file_put_contents('./db/'.$data['nickname'], serialize($data['secret']));
    }
    file_put_contents('./data/'.$data['nickname'].'-'.time().'.yaml', $raw);
    file_put_contents('./data/'.$data['nickname'].'-latest.yaml', $raw);
  } else {
    header("HTTP/1.1 403 Forbidden: nickname or secret missing.");
    print "nickname or secret missing.";
    die;
  }
}

function process_get() {
  #header("HTTP/1.1 403 Forbidden: not implemented.");
  #print "not implemented.";
  $objs = 0;
  $data = array();
  $scores = array();
  $currents = array();
  foreach (glob('./data/*-latest.yaml') as $filename) {
    $raw = file_get_contents($filename);
    $input = yaml_parse($raw);
    if ($input['nickname']) {
      $data[$input['nickname']] = $input;
      $data[$input['nickname']]['score'] = 0;
      unset($data[$input['nickname']]['secret']);
      unset($data[$input['nickname']]['remark']);
      foreach ($input as $k => $v) {
        if ($v['tasks_done']) {
          $data[$input['nickname']]['score'] += $v['tasks_done'];
        }
      }

      if (file_exists('./db/'.$input['nickname'].'-extra')) {
        $extra = unserialize(file_get_contents('./db/'.$input['nickname'].'-extra'));
        $data[$input['nickname']]['score'] += $extra;
      } else {
        file_put_contents('./db/'.$input['nickname'].'-extra', serialize(0));
      }

      $scores[$input['nickname']] = $data[$input['nickname']]['score'];
      $currents[$input['nickname']] = $data[$input['nickname']]['current'];
      $objs++;
    }
  }
  if ($objs) {
    array_multisort($scores, SORT_DESC, SORT_NUMERIC, $currents, SORT_DESC, $data);
  }
  if ($_SERVER["QUERY_STRING"] == 'json') {
    header('Content-type: application/json');
    print json_encode($data);
    exit;
  }
  if ($_SERVER["QUERY_STRING"] == 'yaml') {
    header('Content-type: text/yaml');
    print yaml_emit($data);
    exit;
  }
  $place = 1;
  header("Refresh: 15");
  print "<html>
<head>
<title>p4h scoreboard</title>
<link href='https://fonts.googleapis.com/css?family=Black+Ops+One&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
<style>
table {
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #9F80A9;
    padding: 5px;
    font-family: 'Black Ops One', courier, cursive;
    font-size: 50px;
    color: #794789;
}

strong {
    color: #fff;
    font-weight: normal;
    text-shadow: -1px -1px 0 #642C76, 1px -1px 0 #642C76, -1px 1px 0 #642C76, 1px 1px 0 #642C76;
}

a {
    text-decoration: none;
    color: #9F80A9;
}

a:hover {
    color: #BAA4C1;
}
</style>
</head>";
  #print "<pre>";
  #print_r($data);
  #print "</pre>";
  print "<table border=\"1\" noshade>";
  print "<tr><th> # </th><th> nick </th><th> current quest </th><th> score </th></tr>\n";
  if (!$objs) {
    print "<tr><td colspan=\"4\">No one has entered yet.</td></tr>\n";
  } else {
    foreach ($data as $k => $v) {
      print "<tr><td>".$place++.".</td><td><strong>".$k."</strong></td><td><a href=\"https://github.com/asquelt/cmw/blob/master/docs/".$v['current'].".md\">".ucfirst($v['current'])."</a></td><td><strong>".$v['score']."</strong></td></tr>\n";
    }
  }
  print "</table>";
  print "</html>";
}

switch ($_SERVER['REQUEST_METHOD']) {
  case 'POST':
    process_post();
    break;
  case 'GET':
    process_get();
    break;
  deault:
    print "Invalid method.";
    break;
}

?>
