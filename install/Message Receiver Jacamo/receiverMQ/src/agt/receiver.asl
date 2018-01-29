!receive_msgs.

+!receive_msgs : true
<- makeArtifact("receiverPort","environments.EnvMsg",[],Id);
receiveMsg(Msg);
println(Msg);
focus(Id);
startReceiving.

+new_msg(Msg)
<- println(Msg).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$jacamoJar/templates/org-obedient.asl") }
