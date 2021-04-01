clc, clear all;
%% creazione sistemi di riferimento
O = [0;0;0] 
C = [2;1;2]

figure()
quiver3(O,O,O,[1;0;0],[0;1;0],[0;0;1])
hold on
quiver3([C(1);C(1);C(1)],[C(2);C(2);C(2)],[C(3);C(3);C(3)],[0;1;0],[0;0;1],[1;0;0])

text(O(1),O(2),O(3),'O')
text(O(1),O(2)+1,O(3),'Y')
text(O(1)+1,O(2),O(3),'X')
text(O(1),O(2),O(3)+1,'Z')

text(C(1),C(2),C(3),'C')
text(C(1),C(2)+1,C(3),'X')
text(C(1)+1,C(2),C(3),'Z')
text(C(1),C(2),C(3)+1,'Y')
text(C(1),C(2),C(3)-0.2,'Centro ottico')
%%


