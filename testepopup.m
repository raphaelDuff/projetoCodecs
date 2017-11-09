%taxa = choosedialog

taxa = dialogChooseTaxa;

    switch taxa
        case('1/2')
            taxa = [1;1];
        case('2/3')
            taxa = [1;1;0;1];
        case('3/4')
            taxa = [1;1;0;1;1;0];
        case('5/6')
            taxa = [1;1;0;1;1;0;0;1;1;0];
        case('7/8')
            taxa = [1;1;0;1;0;1;0;1;1;0;0;1;1;0];
    end