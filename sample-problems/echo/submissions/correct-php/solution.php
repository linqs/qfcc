<?php

while ($line = fgets(STDIN)) {
    $line = trim($line);
    if (strlen($line) == 0) {
        continue;
    }

    echo "$line\n";
}

?>
