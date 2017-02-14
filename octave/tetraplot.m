% Markidis 2017
function [X] = tetraplot()
% necessita dei pacchetti io e statistics
% pkg install -forge io (dipendenza per stat)
% pkg install -forge statistics (kmeans e altre amenita')
    
oot = 1/3; % one over three
tot = sqrt(2/3); % two over three

% definisco i vertici
% [x y z]
t1 = [0., 0., 1.]; % black
t2 = [2*tot,0.,-oot]; % ciano
t3 = [-tot,tot,-oot]; % magenta
t4 = [-tot,-tot,-oot]; % rosso

T = [t1,t2,t3,t4];
T = reshape(T,3,4);

%A = vec(2*rand(2)-1);
%A = A.^2;
%A = A/sum(A) 
%X = T*A;

% questa e' la procedura per un vettore. per una matrice e'
% uguale concettualmente ma piu' sbatti

% normalizzo il quadrato dell'ampiezza perche'
% suppongo la normalizzazione impone di fissare
% l'energia che e' la roba fisica

% samples di partenza e arrivo
samples = [1,10];

% array e frequenza di campionamento

[LBD,LBDFS] = audioread('pssong/LBD.aif',samples);
[LFU,LFUFS] = audioread('pssong/LFU.aif',samples);
[RBU,RBUFS] = audioread('pssong/RBU.aif',samples);
[RFB,RFBFS] = audioread('pssong/RFB.aif',samples);
% LBD e' una matrice [samples,channels]; 
% questi file sono colonne, quindi perfetto

% sound(LBD,LBDFS); % prova a sentire un canale se funziona...

X = zeros(samples(2),3);

A = [LBD,LFU,RBU,RFB];
% A e' una matrice [samples,4]
% a questo basta fare le stesse operazioni di prima...
% ricorda che in Octave hai A(colonne,righe)

B = abs(A); % lineare o quadratico?
%B = A.^2; 
C = sum(B');
B = B'./C;
%B = B';

X = T*B;
X = X';

%close all;
figure(2)

% plot tetrahedron
hold on;
scatter3(t1(1),t1(2),t1(3),'k');
scatter3(t2(1),t2(2),t2(3),'c');
scatter3(t3(1),t3(2),t3(3),'m');
scatter3(t4(1),t4(2),t4(3),'r');
plot3([t1(1) t2(1)],[t1(2) t2(2)],[t1(3) t2(3)],'-k');
plot3([t1(1) t3(1)],[t1(2) t3(2)],[t1(3) t3(3)],'-b');
plot3([t1(1) t4(1)],[t1(2) t4(2)],[t1(3) t4(3)],'-r');
plot3([t2(1) t3(1)],[t2(2) t3(2)],[t2(3) t3(3)],'-g');
plot3([t2(1) t4(1)],[t2(2) t4(2)],[t2(3) t4(3)],'-c');
plot3([t3(1) t4(1)],[t3(2) t4(2)],[t3(3) t4(3)],'-m');

scatter3(X(:,1),X(:,2),X(:,3),[],X);

hold off;

xlabel('x');
ylabel('y');
zlabel('z');
grid on;

endfunction