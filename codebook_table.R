codebook_table <- desired_features

codebook_table$transformation <- 'Mean of all observations for subject/activity'

codebook_table$unit_of_measure <- 'Standardised between -1 and 1'

codebook_table$notes <- ''

codebook_table <- codebook_table[,c(2,6, 4, 5, 3)]

write.table(codebook_table, 'codebook_table2.txt', sep='|', row.names=FALSE, quote=FALSE)
