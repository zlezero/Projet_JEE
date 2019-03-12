package Classes;

/**
 *
 * @author tvathonn
 */

public class Joueur {
    
    private Partie[] listeParties;
    private int idJoueur;
    
    public Joueur(int idJoueur, int nbrParties) {
        
        this.idJoueur = idJoueur;
        
        if (nbrParties >= 10) {
            listeParties = new Partie[10];
        }
        else if (nbrParties <= 5) {
            listeParties = new Partie[5];
        }
        else {
            listeParties = new Partie[nbrParties];
        }
            
    }
    
    public void jouer() {
        for (int i = 0; i != listeParties.length; i++) {
            listeParties[i] = new Partie();
            listeParties[i].Jouer();
        }
    }
    
    public Partie getPartie(int i) {
        return listeParties[i];
    }
    
    public int getNbrParties() {      
        return listeParties.length;      
    }
    
}
