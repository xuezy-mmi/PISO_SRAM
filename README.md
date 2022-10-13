# PISO_SRAM
parallel input serial output SRAM

## module describe：

A parallel receiving and serial sending buffer is designed. Its data storage is realized by dual port SRAM (one read and one write). The SRAM size is 64 deep and 32 wide bits (64 words × 32 bits). The buffer receives data according to 32-bit parallel input, and can cache up to 64 groups of data. When the buffer is full, it will not receive parallel data input; At the same time, according to the reading request, the received 32-bit data can be sent out serially by bit in the order of receiving data. To complete the transmission of the word, the address of the word needs to be empty, and new parallel input data can be placed. When reading and writing the same address data at the same time, it is assumed that the latest write data can be obtained by the read operation.
