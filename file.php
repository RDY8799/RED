<?php

$function = $_POST['function'];

$server_ip = $_POST['ip'];
$server_user = $_POST['user'];
$server_port = $_POST['port'];
$server_password = $_POST['pass'];

$nome = $_POST['nome'];
$dias = $_POST['dias'];
$limit = $_POST['limit'];
$password = $_POST['password'];


if (strpos($function, "delete_user") !== false){
    $comando = "printf '$nome\\n' | nuser.sh $function";
}elseif (strpos($function, "create_user") !== false){
    $comando = "printf '$nome\\n$password\\n$dias\\n$limit\\n' | nuser.sh $function";
}elseif (strpos($function, "create_user_time") !== false) {
    $comando = "printf '$nome\\n$password\\n$dias\\n' | nuser.sh $function";
}elseif (strpos($function, "change_user_limit") !== false) {
    $comando = "printf '$nome\\n$limit\\n' | nuser.sh $function";
}elseif (strpos($function, "change_user_date") !== false) {
    $comando = "printf '$nome\\n$dias\\n' | nuser.sh $function";
}elseif (strpos($function, "change_passwod") !== false) {
    $comando = "printf '$nome\\n$password\\n' | nuser.sh $function";
}elseif (strpos($function, "remove_user_limit") !== false) {
    $comando = "printf '$nome\\n' | nuser.sh $function";
}elseif (strpos($function, "disconect_user") !== false) {
    $comando = "printf '$nome\\n' | nuser.sh $function";
}elseif (strpos($function, "info_user") !== false) {
    if ($nome !== null) {
    $comando = "printf '$nome\\n' | nuser.sh $function";
    }else {
    $comando = "nuser.sh $function";
    }
}




if($ssh = ssh2_connect($server_ip, $server_port)) {
    if(ssh2_auth_password($ssh, $server_user, $server_password)) {
        $stream = ssh2_exec($ssh, $comando);
        stream_set_blocking($stream, true);
        $data = '';
        while($buffer = fread($stream, 4096)) {
            $data .= $buffer;
        }
        fclose($stream);
        if (strpos($data, "RDYOK") !== false) {
            echo "[$data] Sucesso!!";
            
        }else{
            if (strpos($data, "RDYEXISTS") !== false) {
                echo "[$data] Ja existe no servidor";
                
            }elseif (strpos($data, "RDYNOEXISTS") !== false){
                echo "[$data] Usuario nao existe no servidor";
                
            }
        }
    }
}

?>