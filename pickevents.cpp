#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <cmath>

int main()
{

    int n5 =2;   // 0-5,5-10
    int n10=4;   //10-20,20-30,30-40,40-50 bins

    int ibins1 =120;    int ibins2 =240;
    int fbins1 = 50;    int fbins2 =100;

    std::vector <int> ideve;
    std::vector <int> fideve;

    std::ofstream out("chosenlist.dat");

    std::ifstream in("mult_list.dat");
    std::string line;
    if(!in)
    {
        std::cerr<<"Can't open file"<<std::endl;
        exit(1);
    }

    while(getline(in,line))
    {
        int dummy1,dummy2;
        std::stringstream iss(line);
        iss >> dummy1>>dummy2;
        ideve.push_back(dummy1);
    }
    auto sz =ideve.size();
    std::cout<<"size: "<<sz <<std::endl;

    int offset = 0;
    double step1 = static_cast<double>(ibins1) / fbins1;
    double step2 = static_cast<double>(ibins2) / fbins2;
    std::cout << "1st loop starts" << std::endl;

    for (int i = 0; i < n5; i++)
    {
       for (int j = 0; j < fbins1; j++)
       {
           int m = offset + static_cast<int>(std::round(j * step1));
           if (m < 0 || m >= static_cast<int>(ideve.size()))
           {

               std::cerr << "Index out of range in 1st loop: " << m << std::endl;
               break;
           }
        std::cout << j << "\t" << m << std::endl;
        out << ideve[m] << std::endl;
        }
        offset += ibins1;
    }
    std::cout << "2nd loop" << std::endl;

    for (int i = 0; i < n10; i++)
    {
        for (int j = 0; j < fbins2; j++)
        {
            int m = offset + static_cast<int>(std::round(j * step2));
               if (m < 0 || m >= static_cast<int>(ideve.size()))
               {
                    std::cerr << "Index out of range in 2nd loop: " << m << std::endl;
                    break;
               }
               std::cout << j << "\t" << m << std::endl;
               out << ideve[m] << std::endl;
        }
    offset += ibins2;
    }                                                                                                                                                                                                                                                                                                                                                                                        


    return (0);
}
~      
