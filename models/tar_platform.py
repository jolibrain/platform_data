import glob
import os
import tarfile
import datetime
import sys
import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--platform-dir',help='path to platform models directory, e.g. /media/models/xxx/platform/desktop/')
args = parser.parse_args()    

now = datetime.datetime.now()
today_date = now.strftime('%Y%m%d-%H%M')
platform_tarball = args.platform_dir + 'platform_desktop_models-' + today_date + '.tar.gz'

tar = tarfile.open(platform_tarball,"w:gz")

for filename in glob.iglob(args.platform_dir + '**', recursive=True):
    if os.path.isdir(filename):
        find_config = glob.glob(filename + "/config.json")
        if find_config:
            with open(filename + '/config.json') as jf:
                #print(filename + '/config.json')
                jdata = json.load(jf)
                jdata['model'] = {'repository':'/opt/platform/models/public/'+os.path.basename(filename)}
                with open(filename + '/config_path.json','w+') as ojf:
                    json.dump(jdata,ojf)
            model_files = glob.glob(filename + "/*")
            #print(model_files)
            for mf in model_files:
                mft_elts = mf.split('/')
                #print(mft_elts)
                model_directory = mft_elts[len(mft_elts)-2]
                model_file = mft_elts[len(mft_elts)-1]
                if model_file == 'config.json':
                    continue
                elif model_file == 'config_path.json':
                    mft = model_directory + '/config.json'
                else:
                    mft = model_directory + '/' + model_file
                #print(mf,mft)
                tar.add(name=mf,arcname=mft)
                if model_file == 'config_path.json':
                    os.remove(mf)
# symlink to latest
os.symlink(platform_tarball,args.platform_dir + 'platform_desktop_models_latest.tar.gz')
tar.close()
