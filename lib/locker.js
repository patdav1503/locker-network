/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';
/**
 * Write your transction processor functions here
 */

/**
 * Square a given number transaction
 * @param {org.locker.mynetwork.doSquare} newTrans
 * @transaction
 */
async function doSquare(newTrans) {
    // Validate input references
    var lockerId;
    // Validate input references
    if (newTrans.lockerId) {
        lockerId = newTrans.lockerId;
    } else {
        lockerId = 'abcdefg';
    }

    // This is the factory for creating instances of types.
    var factory = getFactory();
    var NS = 'org.locker.mynetwork';

    var myLocker = factory.newResource(NS, 'IntegerLocker', lockerId);
    myLocker.owner = getCurrentParticipant();
    myLocker.returnValue = newTrans.intValue * newTrans.intValue;
    myLocker.errorCode = 0;

    await getAssetRegistry(NS + '.IntegerLocker')
        .then(function(lockerRegistry) {
            // Add the message
            return lockerRegistry.addAll([myLocker]);
        });



}

