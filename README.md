# locker-network

Transaction locker network - allows results to be returned from transactions and only the caller can see the results.

This business network defines:

**Participants:**
`Member` `Admin`

**Assets:**
`TransactionLocker` `IntegerLocker`

**Transactions:**
`doSquare`

To test this Business Network Definition using **Composer CLI**

From the top directory with `package.json`, run `npm install` to install network and required packages into `npm`.  Use `npm test` to run the test using `mocha` and `cucumber` as defined in the `package.json` file.  Mocha tests are located in the test subdirectory and are written in Javascript.  Cumcumber tests are located in the features subdirectory and are written in the cucumber format.

To test this Business Network Definition in the **Test** tab:

