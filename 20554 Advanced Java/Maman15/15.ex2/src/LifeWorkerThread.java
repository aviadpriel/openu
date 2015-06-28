/**
 * Created by Stas on 28/06/2015 22:26.
 */

public class LifeWorkerThread implements Runnable
{
    private GameOfLife gameOfLife;
    private int row;
    private int col;

    public LifeWorkerThread(GameOfLife gameOfLife, int row, int col)
    {

        this.gameOfLife = gameOfLife;
        this.row = row;
        this.col = col;
    }

    @Override
    public void run()
    {
        //get number of neighbors
        int neighbors = gameOfLife.getLivingNeighbors(this.row, this.col);

        //calculate next gen state
        boolean currentState = gameOfLife.getCellState(this.row, this.col);
        boolean nextGenState;

        //birth
        if (!currentState && neighbors == 3)
        {
            nextGenState = true;
        }

        //life
        else if (currentState && neighbors >= 2 && neighbors <= 3)
        {
            nextGenState = true;
        }

        //death
        else
        {
            nextGenState = false;
        }

        //set new gen state
        gameOfLife.setNextGenerationState(this.row, this.col, nextGenState);
    }
}
