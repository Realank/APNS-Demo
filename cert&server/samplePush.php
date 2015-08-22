<?php  
  
// ??????????deviceToken???????????????  
$deviceToken = '9018849e5407fb1695e6dfd1772506093afe5fe72d958c08c1233ac3c674d0bd';  
  
// Put your private key's passphrase here:  
$passphrase = '901207';  
  
// Put your alert message here:  
$message = 'Hello world';  
  
////////////////////////////////////////////////////////////////////////////////  
  
$ctx = stream_context_create();  
stream_context_set_option($ctx, 'ssl', 'local_cert', 'final_push_developer.pem');  
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);  
  
// Open a connection to the APNS server  
//??????????  
 //$fp = stream_socket_client(?ssl://gateway.push.apple.com:2195?, $err, $errstr, 60, //STREAM_CLIENT_CONNECT, $ctx);  
//?????????????appstore??????  
$fp = stream_socket_client(  
'ssl://gateway.sandbox.push.apple.com:2195', $err,  
$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);  
  
if (!$fp)  
exit("Failed to connect: $err $errstr" . PHP_EOL);  
  
echo 'Connected to APNS' . PHP_EOL;  
  
// Create the payload body  
$body['aps'] = array(  
'alert' => $message,  
'sound' => 'default',
'badge' => 5  
);  
  
// Encode the payload as JSON  
$payload = json_encode($body);  
  
// Build the binary notification  
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;  
  
// Send it to the server  
$result = fwrite($fp, $msg, strlen($msg));  
  
if (!$result)  
echo 'Message not delivered' . PHP_EOL;  
else  
echo 'Message successfully delivered' . PHP_EOL;  
  
// Close the connection to the server  
fclose($fp);  
?>  