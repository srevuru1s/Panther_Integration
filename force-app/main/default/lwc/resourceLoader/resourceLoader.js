import { LightningElement } from 'lwc';

import { loadScript } from 'lightning/platformResourceLoader';
import CHART_JS from '@salesforce/resourceUrl/ChartJs'

export default class ResourceLoader extends LightningElement {

    isRender = false;

    connectedCallback() {

        if(this.isRender) {
            return;
        } else {
            this.isRender = true;

            loadScript(this,CHART_JS)
                .then((results) =>{
                    console.log('The data has been loaded :', this.results);
                    const ctx = this.refs.myChart;
                    console.log('ref :', ctx);
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                        datasets: [{
                            label: '# of Votes',
                            data: [12, 19, 3, 5, 2, 3],
                            borderWidth: 1
                        }]
                        },
                        options: {
                        scales: {
                            y: {
                            beginAtZero: true
                            }
                        }
                        }
                    });
                })
                .catch((error)=> {
                    console.error(error);
                })
        }

    }
}