file = open("./initial-points-generator/generate_initial_points_single_arch_0_motion_0.m", "r")
content = file.read()
#print(content)
file.close()




for archId in range(1,15):
    for motionId in range(1,15):
        copy = content
        copy = copy.replace('archId = 0;', 'archId = ' + str(archId) + ';')
        copy = copy.replace('motionId = 0;', 'motionId = '+ str(motionId) + ';')
        print(archId, motionId)
        
        filename = "./initial-points-generator/generate_initial_points_single_arch_"+str(archId)+"_motion_"+str(motionId)+".m"
        with open(filename, "w") as text_file:
            text_file.write(copy)
        
print(copy)