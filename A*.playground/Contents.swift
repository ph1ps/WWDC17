import PlaygroundSupport
import UIKit
/*:
 ## A* algorithm with UIKit
 This playground demonstrates the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm) and also visualizes how it works with UIKit elements. This algorithm is commonly seen in computer games for pathfinding but also in practical travel-routing systems.
 
 Let's create an instance of our Main-View and show it.
 */
PlaygroundPage.current.liveView = Main()

/*:
 ### Explanation
 As you can see there are 3 different elements. A coin, a player and crates. Each of those objects represent a role in the algorithm.
 * ***Player***: eg. the car which wants to find a route
 * ***Coin***: eg. the destination of the route
 * ***Crate***: eg. obstacles, where your car is not allowed to go through (houses, bushes)
 
 You can now start dragging those elements into the fields and press the "Locate" button!

 - Note:
 Try making it hard for the algorithm, use more crates, so it has to find ways around it
 
 
 These values below are the weights of a route. The diagonally weight is used when moving diagonally in the square. The horizontally weight is used for moving in a straight line (up, down, left, right).
 
 You can try changing them and see if it affects the process of finding the route
*/
Algorithm.shared.weightDiagonally = 14      // √1²+1² * 10 --> hypotenuse of the square
Algorithm.shared.weightHorizontally = 10    // 1 * 10 --> length of a side of the square
/*:
 - Callout(Why times 10?):
 Because no one likes numbers with decimals! It is just for the sake of readability.
 
 ### Heuristics
 This algorithm utilizes a special concept called Heuristics. This sort of guides the algorithm to the destination even faster. In thise case it tells the algorithm the distance to the destination. 
 
 Commonly speaking there are 3 variables in this algorithm.
 * ***G-value***: distance to the start node (car)
 * ***H-value***: distance to the end node (destination) -> ***Heuristics***
 * ***F-value***: the above values combined (G+H)

*/

//: ![](demo.png)
/*:
 ### Magic
 Now we only need to combine everything from above to get this working. A* looks through all the F-values of the ***neighbor nodes*** from the starting point and picks the one with the lowest value, meaning the best route. Now switch the view to the selected node and do the same process again.
 
 Continue this until you have reached your destination.
 
 Now go ahead and use this algorithm for your pathfinding problem in your Applications.
 */
