Feature: Locker Network

    Background:
        Given I have deployed the business network definition ..
        And I have added the following participants of type org.locker.mynetwork.Member
            | userId          | firstName | lastName |
            | alice@email.com | Alice     | A        |
            | bob@email.com   | Bob       | B        |
        And I have added the following assets of type org.locker.mynetwork.IntegerLocker
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"001", "owner":"org.locker.mynetwork.Member#alice@email.com", "returnValue":100, "errorCode":0},
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"002", "owner":"org.locker.mynetwork.Member#bob@email.com", "returnValue":-1, "errorCode":500}
            ]
            """
        And I have issued the participant org.locker.mynetwork.Member#alice@email.com with the identity alice1
        And I have issued the participant org.locker.mynetwork.Member#bob@email.com with the identity bob1

    Scenario: Alice can read only her assets
        When I use the identity alice1
        Then I should have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"001", "owner":"org.locker.mynetwork.Member#alice@email.com", "returnValue":100, "errorCode":0}
            ]
            """

    Scenario: Bob can read only his assets
        When I use the identity bob1
        Then I should have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"002", "owner":"org.locker.mynetwork.Member#bob@email.com", "returnValue":-1, "errorCode":500}
            ]
            """

    Scenario: Alice can remove her assets
        When I use the identity alice1
        And I remove the following asset of type org.locker.mynetwork.IntegerLocker
            | lockerId |
            | 001      |
        Then I should not have the following assets of type org.locker.mynetwork.IntegerLocker
            | lockerId |
            | 001      |

    Scenario: Alice cannot remove Bob's assets
        When I use the identity alice1
        And I remove the following asset of type org.locker.mynetwork.IntegerLocker
            | lockerId |
            | 002      |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Bob can remove his assets
        When I use the identity bob1
        And I should have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"002", "owner":"org.locker.mynetwork.Member#bob@email.com", "returnValue":-1, "errorCode":500}
            ]
            """
        And I remove the following asset of type org.locker.mynetwork.IntegerLocker
            | lockerId |
            | 002      |
        Then I should not have the following assets of type org.locker.mynetwork.IntegerLocker
            | lockerId |
            | 002      |

    Scenario: Bob cannot remove Alice's assets
        When I use the identity bob1
        And I remove the following asset of type org.locker.mynetwork.IntegerLocker
            | lockerId |
            | 001      |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: Alice can get a square
        When I use the identity alice1
        And I submit the following transaction
            """
            [
            {"$class":"org.locker.mynetwork.doSquare", "lockerId":"051", "intValue": 15 }
            ]
            """
        Then I should have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"051", "owner":"org.locker.mynetwork.Member#alice@email.com", "returnValue":225, "errorCode":0}
            ]
            """

    Scenario: Alice can get a square but Bob can't access the locker
        When I use the identity alice1
        And I submit the following transaction
            """
            [
            {"$class":"org.locker.mynetwork.doSquare", "lockerId":"051", "intValue": 15 }
            ]
            """
        And I should have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"051", "owner":"org.locker.mynetwork.Member#alice@email.com", "returnValue":225, "errorCode":0}
            ]
            """
        And I use the identity bob1
        Then I should not have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"051", "owner":"org.locker.mynetwork.Member#alice@email.com", "returnValue":225, "errorCode":0}
            ]
            """

    Scenario: Bob can get a square
        When I use the identity bob1
        And I submit the following transaction
            """
            [
            {"$class":"org.locker.mynetwork.doSquare", "lockerId":"051", "intValue": 15 }
            ]
            """
        Then I should have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"051", "owner":"org.locker.mynetwork.Member#bob@email.com", "returnValue":225, "errorCode":0}
            ]
            """

    Scenario: Bob can get a square but Alice can't access the locker
        When I use the identity bob1
        And I submit the following transaction
            """
            [
            {"$class":"org.locker.mynetwork.doSquare", "lockerId":"051", "intValue": 15 }
            ]
            """
        And I should have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"051", "owner":"org.locker.mynetwork.Member#bob@email.com", "returnValue":225, "errorCode":0}
            ]
            """
        And I use the identity alice1
        Then I should not have the following assets
            """
            [
            {"$class":"org.locker.mynetwork.IntegerLocker", "lockerId":"051", "owner":"org.locker.mynetwork.Member#bob@email.com", "returnValue":225, "errorCode":0}
            ]
            """


