codebook_table <- desired_features

codebook_table$transformation <- 'Mean of all observations for subject/activity'

codebook_table$unit_of_measure <- 'Standardised between -1 and 1'

codebook_table <- codebook_table[,c(2,4, 5, 3)]

codebook_table$notes <- ''

write.table(codebook_table, 'codebook_table.txt', sep='|', row.names=FALSE, quote=FALSE)
