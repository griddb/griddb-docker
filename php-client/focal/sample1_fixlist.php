<?php
    if (file_exists('griddb_php_client.php')) {
        // File php wrapper is generated with SWIG 4.0.2 and below
        include_once('griddb_php_client.php');
    }

    $factory = StoreFactory::getInstance();

    $blob = pack('C*', 65, 66, 67, 68, 69, 70, 71, 72, 73, 74);
    $update = true;

    try {
        // Get GridStore object
       $gridstore = $factory->getStore(array("notificationMember" => $argv[1],
                       "clusterName" => $argv[2],
                       "username" => $argv[3],
                       "password" => $argv[4]
                   ));

        // Create a collection container
        $conInfo = new ContainerInfo(["name" => "col01",
                                   "columnInfoArray" => [["name", Type::STRING],
                                                        ["status", Type::BOOL],
                                                        ["count", Type::LONG],
                                                        ["lob", Type::BLOB]],
                                   "type" => ContainerType::COLLECTION,
                                   "rowKey" => true]);
        $gridstore->dropContainer("col01");
        $col = $gridstore->putContainer($conInfo);

        // Change auto commit mode to false
        $col->setAutoCommit(false);

        // Set an index on the Row-key Column
        $col->createIndex("name");

        // Set an index on the Column
        $col->createIndex("count");

        // Put row: RowKey is "name01"
        $ret = $col->put(["name01", false, 1, $blob]);
        // Remove row with RowKey "name01"
        $col->remove("name01");

        // Put row: RowKey is "name02"
        $col->put(["name02", false, 1, $blob]);
        $col-> commit();

        $mArray = $col->get("name02");

        // Create normal query
        $query = $col->query("select * where name = 'name02'");

        // Execute query
        $rs = $query->fetch($update);
        while ($rs->hasNext()) {
            $data = $rs->next();
            $data[2] = $data[2] + 1;
            echo("Person: name=$data[0] status=".($data[1] ? "true" : "false")
                    ." count=$data[2] lob=$data[3]\n");

            // Update row
            $rs->update($data);
        }

        // End transction
        $col->commit();
        echo("success!\n");
    } catch (GSException $e) {
        for ($i= 0; $i < $e->getErrorStackSize(); $i++) {
            echo("\n[$i]\n");
            echo($e->getErrorCode($i)."\n");
            echo($e->getLocation($i)."\n");
            echo($e->getErrorMessage($i)."\n");
        }
    }
?>
