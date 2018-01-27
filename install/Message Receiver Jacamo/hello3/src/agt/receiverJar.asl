!receive_msgs.

+!receive_msgs : true
<- makeArtifact("receiverJar","testCartago.EnvJar",[],Id);
receiveMsg(Msg);
println("Ricevuto il file: ",Msg);
focus(Id);
startReceiving.

+new_msg(Msg)
<- println("Ricevuto il file: ",Msg).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$jacamoJar/templates/org-obedient.asl") }
